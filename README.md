# Pfcrawl

Web scraper for PF2E assets.

## Running the Scraper
```
mix deps.get
iex -S mix run -e "Crawly.Engine.start_spider(Pfcrawl.Monsters)"
```