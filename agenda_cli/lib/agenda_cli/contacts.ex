defmodule AgendaCli.Contacts do
  def delete(list, id) do
    Enum.reject(list, fn contato -> contato.id == id end)
  end

  def add(list, infos) do
    contato = Map.put(infos, :id, System.os_time(:millisecond))
    [contato | list]
  end

  def edit(list, id, mudanca) do
    Enum.map(list, fn contato ->
      if contato.id == id do
        Map.merge(contato, mudanca)
      else
        contato
      end
    end)
  end

  def search(list, {campo, valor}) do
    Enum.filter(list, fn contato ->
      String.contains?(
        String.downcase(contato[campo]),
        String.downcase(valor)
      )
    end)
  end
  defp junta([], acumulado) do
  {Enum.join(Enum.reverse(acumulado), " "), []}
end

defp junta([palavra | resto], acumulado) do
  if String.starts_with?(palavra, "--") do
    {Enum.join(Enum.reverse(acumulado), " "), [palavra | resto]}
  else
    junta(resto, [palavra | acumulado])
  end
end
def parse_flags(lista), do: parse_flags(lista, %{})

defp parse_flags([], mapa), do: mapa

defp parse_flags(["--name" | resto], mapa) do
  {valor, sobra} = junta(resto, [])
  parse_flags(sobra, Map.put(mapa, :name, valor))
end

defp parse_flags(["--company" | resto], mapa) do
  {valor, sobra} = junta(resto, [])
  parse_flags(sobra, Map.put(mapa, :company, valor))
end

defp parse_flags(["--phone" | resto], mapa) do
  {valor, sobra} = junta(resto, [])
  parse_flags(sobra, Map.put(mapa, :phone, valor))
end

defp parse_flags(["--email" | resto], mapa) do
  {valor, sobra} = junta(resto, [])
  parse_flags(sobra, Map.put(mapa, :email, valor))
end
end
