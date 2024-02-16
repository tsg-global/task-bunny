defmodule TaskBunny do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TaskBunny.Status

  @spec start(atom, term) :: {:ok, pid} | {:ok, pid, any} | {:error, term}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    register_metrics()

    TaskBunny.Supervisor.start_link()
  end

  defp register_metrics do
    if Code.ensure_loaded(Wobserver) == {:module, Wobserver} do
      Wobserver.register(:page, {"Task Bunny", :taskbunny, &Status.page/0})
      Wobserver.register(:metric, [&Status.metrics/0])
    end
  end
end
