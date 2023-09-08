IEx.configure(
  colors: [
    enabled: true,
    eval_result: [:light_green],
    eval_error: [:light_magenta],
    stack_info: [:light_blue]
  ],
  default_prompt:
    [
      # a neon purple
      "\r\e[38;5;129m",
      # IEx context
      "%prefix",
      # forest green expression count
      "\e[38;5;112m(%counter)",
      # neon purple ">"
      "\e[38;5;129m>",
      # and reset to default color
      "\e[0m"
    ]
    |> IO.chardata_to_string()
)

alias BikeShop.Accounts
alias BikeShop.Bikes
