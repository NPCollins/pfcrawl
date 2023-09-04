# lib/crawly_example/books_to_scrape.ex
defmodule Pfcrawl.Monsters do
  use Crawly.Spider

  @last_monster 2

  @impl Crawly.Spider
  def base_url(), do: "https://2e.aonprd.com/"

  @impl Crawly.Spider
  def init() do
    urls = Enum.map(1..@last_monster, fn id -> "https://2e.aonprd.com/Monsters.aspx?ID=#{id}" end)
    [start_urls: urls]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    IO.inspect(response.request_url)
    # Parse response body to document
    {:ok, document} = Floki.parse_document(response.body)

    # Create item (for pages where items exists)
    base = "body div form div div div div "

    name =
      document
      |> Floki.find(base <> "span#ctl00_RadDrawer1_Content_MainContent_DetailedOutput h1.title")
      |> Floki.text([deep: false])

    img =
      document
      |> Floki.find(base <> "a img.thumbnail")
      |> Floki.attribute("src")
      |> Floki.text

    IO.inspect(%{name: name, img: img})
  end
end
