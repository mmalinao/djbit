defmodule DjBitWeb.PageView do
  use DjBitWeb, :view
  import DjBit.Slack, only: [authorize_url: 0]
end
