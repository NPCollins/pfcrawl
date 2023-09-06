# lib/crawly_example/books_to_scrape.ex
defmodule Pfcrawl.Monsters do
  use Crawly.Spider

  @starting_monster 1
  @last_monster 2
  #@last_monster 2690
  @base_url "https://2e.aonprd.com/"

  @impl Crawly.Spider
  def base_url(), do: @base_url

  @impl Crawly.Spider
  def init() do
    urls = Enum.map(@starting_monster..@last_monster, fn id -> "https://2e.aonprd.com/Monsters.aspx?ID=#{id}" end)
    [start_urls: urls]
  end

  @impl Crawly.Spider
  def parse_item(response) do
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

    sanitized_name =
      name 
      |> String.replace(~r/\(.*\)/, "")
      |> String.replace(~r/[ |(|)|_|-]/, "")
    
    get_image(@base_url <> Regex.replace(~r/\\/, img, "/"), sanitized_name)

    IO.inspect(%{name: name, img: img})
  end

  def get_image(@base_url, name) do
    File.write!("./out/monsters/noimage", name <> "\n", [:append])
  end
  def get_image(url, name) do
    [_, extension] = Regex.run(~r/(\.[a-z]+)$/, url)
    image = Req.get!(url)
    File.write!("./out/monsters/#{name}#{extension}", image.body)
  end
end
