{ ... }:
{
  imports = [ ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = "tab";
        indent_style = "tab";
        insert_final_newline = true;
        tab_width = 3; # I am a monster
        trim_trailing_whitespace = true;
      };

      "*.lua" = {
        align_array_table = true;
        align_call_args = false;
        align_continuous_assign_statement = false;
        align_continuous_inline_comment = true;
        align_continuous_rect_table_field = false;
        align_function_params = false;
        align_if_branch = false;
        auto_collapse_lines = true;
        break_all_list_when_line_exceed = true;
        call_arg_parentheses = "remove_table_only";
        continuation_indent = 1;
        detect_end_of_line = false;
        ignore_space_after_colon = false;
        ignore_spaces_inside_function_call = false;
        line_space_after_comment = "max(2)";
        line_space_after_do_statement = "max(2)";
        line_space_after_expression_statement = "max(2)";
        line_space_after_for_statement = "max(2)";
        line_space_after_function_statement = "fixed(2)";
        line_space_after_if_statement = "max(2)";
        line_space_after_local_or_assign_statement = "max(2)";
        line_space_after_repeat_statement = "max(2)";
        line_space_after_while_statement = "max(2)";
        max_line_length = 120;
        never_indent_before_if_condition = false;
        never_indent_comment_on_if_branch = false;
        quote_style = "single";
        remove_call_expression_list_finish_comma = false;
        space_after_comma = true;
        space_after_comma_in_for_statement = true;
        space_around_concat_operator = true;
        space_around_math_operator = true;
        space_around_table_append_operator = false;
        space_around_table_field_list = true;
        space_before_attribute = true;
        space_before_closure_open_parenthesis = false;
        space_before_function_call_open_parenthesis = false;
        space_before_function_call_single_arg = false;
        space_before_function_open_parenthesis = false;
        space_before_inline_comment = 1;
        space_before_open_square_bracket = false;
        space_inside_function_call_parentheses = false;
        space_inside_function_param_list_parentheses = false;
        space_inside_square_brackets = false;
        trailing_table_separator = "smart";
      };

      "*.{libsonnet,jsonnet,nix,rpy,yaml,yml}" = {
        indent_style = "space";
        tab_width = 2;
      };

      "doc/*.txt" = {
        max_line_length = 80;
      };
    };
  };
}
