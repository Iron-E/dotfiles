{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];

  programs.fish.functions.srun = lib.optionalAttrs pkgs.stdenv.isLinux {
    description = "Run a command in a transient systemd scope.";
    body = # fish
      ''
        argparse \
        (fish_opt -s h -l help) \
        (fish_opt -l dry-run) \
        (fish_opt -s m -l memory-high -r) \
        (fish_opt -s M -l memory-max -r) \
        (fish_opt -s n -l unit-name -r) \
        (fish_opt -s p -l cpu-quota-period -r) \
        (fish_opt -s q -l cpu-quota -r) \
        (fish_opt -s w -l cpu-weight -r) \
        -- \
        $argv

        if [ -n "$_flag_help" ] || [ -z "$argv" ]
          echo "\
          Usage: srun [OPTIONS] -- COMMAND

          Example: srun -c 25% -n 'while' -- sh -c 'while true; do :; done'

          Arguments:
            <COMMAND>
              The command to run in the systemd slice.

          Options:
            -h, --help
              Print help

            --dry-run
              Only show the systemd-run command that would be run.
              Don't actually run anything.

            -n, --unit-name
              A name for the <COMMAND>.

          CPU Options:
            -p DURATION, --cpu-quota-period=DURATION
              The duration over which the <COMMAND>\'s --cpu-quota is measured.

              For example, given `-p 2s -q 25%`, the <COMMAND> may only use
              25% cpu within the span of two seconds.

              By default, this is given in seconds. However, the suffix 'ms'
              or 's' may be used to provide the unit of measure explicitly.
              Note that the value given will be clamped to the range supported
              by the kernel, which is 1..=1000ms.

              If not specified, the default setting is 100ms.

            -q QUOTA, --cpu-quota=QUOTA
              The share of time on the cpu that the <COMMAND> may use, as a percent.

              For example, '-q 20%' allows the <COMMAND> to use 20% of the CPU's time.

              Values greater than 100% allow the <COMMAND> to use more than one CPU.

            -w WEIGHT --cpu-weight=WEIGHT
              The priority of the <COMMAND>, which is considered when scheduling CPU time.

              Expressed as an integer in the range 1..=10000, or the word 'idle'.
              When unset, the kernel default is 10.

              Higher integers have higher priority for CPU time when they request it.
              If they don't need CPU time over a given period, then lower integers are
              free to use the CPU more.

              If 'idle', the <COMMAND> will only progress when there are not other non-'idle'
              processes currently requesting CPU time.

          Memory Options:
            -m MEMORY, --memory-high=MEMORY
              An amount of memory, after which the <COMMAND> will be throttled.
              May be suffixed with (K)ibibytes, (M)ebibytes, (G)ibibytes,
              or (T)ebibytes.

              For example, '-m 20K' imposes a limit of 20 kibibytes.

            -M MEMORY, --memory-max=MEMORY
              The maximum amount of memory, after which the OOM killer will be invoked.
              Uses the same format as --memory-high."

          return
        end

        set -f args
        if [ -n "$_flag_unit_name" ]
          set --append args --unit "$_flag_unit_name"
        end

        if [ -n "$_flag_cpu_quota" ]
          set --append args --property "CPUQuota=$_flag_cpu_quota"
        end

        if [ -n "$_flag_cpu_quota_period" ]
          set --append args --property "CPUQuotaPeriodSec=$_flag_cpu_quota_period"
        end

        if [ -n "$_flag_cpu_weight" ]
          set --append args --property "CPUWeight=$_flag_cpu_weight"
        end

        if [ -n "$_flag_memory_high" ]
          set --append args --property "MemoryHigh=$_flag_memory_high"
        end

        if [ -n "$_flag_memory_max" ]
          set --append args --property "MemoryMax=$_flag_memory_max"
        end

        if [ -n "$_flag_dry_run" ]
          echo systemd-run --user --scope $args $argv
          return
        end

        systemd-run --user --scope $args $argv
      '';
  };
}
