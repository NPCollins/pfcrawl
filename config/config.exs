use Mix.Config

config :crawly,
  closespider_timeout: 10,
  concurrent_requests_per_domain: 1,
  middlewares: [
    Crawly.Middlewares.UniqueRequest,
    Crawly.Middlewares.AutoCookiesManager,
    {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot"]}
  ]
