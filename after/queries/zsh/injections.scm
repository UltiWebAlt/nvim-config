; extends

((command
  name: (command_name) @_command
  argument: (raw_string) @injection.content)
  (#eq? @_command "awk")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "awk"))

