{ lib, config, ... }:
{
  imports = [ ];

  home =
    let
      inherit (config) xdg;
      pgConfig = "${xdg.configHome}/pg";
    in
    {
      sessionVariables = {
        PGPASSFILE = "${pgConfig}/pgpass";
        PGSERVICEFILE = "${pgConfig}/pg_service.conf";
        PSQL_HISTORY = "${xdg.stateHome}/psql_history";
        PSQLRC = "${pgConfig}/psqlrc";
      };

      activation.mkPsqlDirs =
        lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
          ''
            run mkdir -p ${pgConfig}
          '';
    };
}
