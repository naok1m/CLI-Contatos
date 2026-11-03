defmodule AgendaCli.Store do
  @file_path "contacts.json"

  def load do
    case File.read(@file_path) do
      {:ok, conteudo} -> Jason.decode!(conteudo, keys: :atoms)
      {:error, _} -> []
    end
  end

  def save(contacts) do
    File.write!(@file_path, Jason.encode!(contacts, pretty: true))
  end
end
