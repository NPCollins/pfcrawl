import Config

config :crawly,
  concurrent_requests_per_domain: 4,
  middlewares: [
    Crawly.Middlewares.UniqueRequest,
    Crawly.Middlewares.AutoCookiesManager,
    {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot"]}
  ]
