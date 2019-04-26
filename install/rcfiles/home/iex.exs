# Add `import_file("~/.iex.exs")` to the project `.iex.exs` to load these
# configurations
IEx.configure(history_size: -1)

IEx.configure(inspect: [limit: :infinity])

IEx.configure(
  colors: [
    enabled: true,
    eval_result: [:cyan, :bright],
    eval_error: [[:red, :bright, "\n▶▶▶\n"]],
    eval_info: [:blue, :bright]
  ]
)

IEx.configure(
  default_prompt:
    [
      # cursor ⇒ column 1
      "\e[G",
      :blue,
      "%prefix",
      [:green, :bright],
      "< ",
      :blue,
      "%counter",
      " ",
      [:green, :bright],
      ">",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)

Application.put_env(:elixir, :ansi_enabled, true)
