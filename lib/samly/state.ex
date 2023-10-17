defmodule Samly.State do
  @moduledoc false

  @state_store :state_store

  def init(store_provider), do: init(store_provider, [])

  def init(store_provider, opts) do
    opts = store_provider.init(opts)
    Application.put_env(:samly, @state_store, %{provider: store_provider, opts: opts})
  end

  def get_assertion(conn, assertion_key) do
    %{provider: store_provider, opts: opts} = Application.get_env(:samly, @state_store)
    store_provider.get_assertion(conn, assertion_key, opts)
  end

  def put_assertion(conn, assertion_key, assertion) do
    %{provider: store_provider, opts: opts} = Application.get_env(:samly, @state_store)
    store_provider.put_assertion(conn, assertion_key, assertion, opts)
  end

  def delete_assertion(conn, assertion_key) do
    %{provider: store_provider, opts: opts} = Application.get_env(:samly, @state_store)
    store_provider.delete_assertion(conn, assertion_key, opts)
  end

  def create_relay_state(conn) do
    %{provider: store_provider, opts: opts} = Application.get_env(:samly, @state_store)
    store_provider.create_relay_state(conn, opts)
  end
end
