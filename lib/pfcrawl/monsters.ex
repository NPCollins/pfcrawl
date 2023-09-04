# lib/crawly_example/books_to_scrape.ex
defmodule Pfcrawl.Monsters do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://2e.aonprd.com/Monsters.aspx"

  @impl Crawly.Spider
  def init() do
    [start_urls: ["https://2e.aonprd.com/Monsters.aspx"]]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    # Parse response body to document
    {:ok, document} = Floki.parse_document(response.body)

    # Create item (for pages where items exists)
    items =
      document
      |> Floki.find("body div form div div div div span nethys-search")
      |> IO.inspect()

    # |> Enum.map(fn row ->
    #   %{
    #     title: Floki.find(row, "h3 a") |> Floki.attribute("title") |> Floki.text(),
    #     price: Floki.find(row, ".product_price .price_color") |> Floki.text(),
    #     url: response.request_url
    #   }
    # end)

    # next_requests =
    #   document
    #   |> Floki.find(".next a")
    #   |> Floki.attribute("href")
    #   |> Enum.map(fn url ->
    #     Crawly.Utils.build_absolute_url(url, response.request.url)
    #     |> Crawly.Utils.request_from_url()
    #   end)

    %{items: items}
  end
end
