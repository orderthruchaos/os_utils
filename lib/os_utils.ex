defmodule OSUtils do
  @moduledoc """
  OS utilities for Elixir.

  Let's face it, some operations are OS-dependent.  Processing `:os.type()`
  over and over again is driving me nuts.  Hopefully these utilities are as
  useful to you as they are to me.

  Note that all operations are performed at runtime to allow generated BEAM
  files to be portable.
  """


  @doc """
  Returns true if the OS ID indicates Windows.  False otherwise.
  """
  def is_win?,  do: os_id === :win32 || os_id === :win64


  @doc """
  Returns true if the OS ID indicates a Unix variant.  False otherwise.
  """
  def is_unix?, do: os_id === :unix


  @doc """
  Returns true if the OS ID indicates OSE.  False otherwise.

  This function still needs proper testing.
  """
  def is_ose?,  do: os_id === :ose


  @doc """
  Return the ID portion of the tuple returned by `:os.type()`.
  """
  def os_id, do: :os.type |> elem 0


  @doc """
  Return the name portion of the tuple returned by `:os.type()`.

  Not generally useful, but here for completeness.
  """
  def os_name, do: :os.type |> elem 1


  @doc """
  Returns true if the OS supports symlinks.  False otherwise.
  """
  def supports_symlinks? do
    case :file.read_link(Path.expand(__ENV__.file)) do
      {:error, :enotsup} -> false
      _                  -> true
    end
  end

end
