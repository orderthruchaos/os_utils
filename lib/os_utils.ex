defmodule OSUtils do
  def is_win?,  do: os_id === :win32 || os_id === :win64
  def is_unix?, do: os_id === :unix
  def is_ose?,  do: os_id === :ose


  def os_id, do: :os.type |> elem 0


  def os_name, do: :os.type |> elem 1


  def supports_symlinks? do
    case :file.read_link(Path.expand(__ENV__.file)) do
      {:error, :enotsup} -> false
      _                  -> true
    end
  end

end
