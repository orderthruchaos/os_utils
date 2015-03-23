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


  # Note: This may need corrected for OSE.
  @doc """
  Returns the character used to separate entries within the PATH/Path
  environment variable
  """
  def path_separator, do: _path_separator(:os.type)
  defp _path_separator({:win32, _}), do: ";"
  defp _path_separator(_          ), do: ":"


  @doc """
  Returns true if the OS supports symlinks.  False otherwise.
  """
  def supports_symlinks? do
    case :file.read_link(Path.expand(__ENV__.file)) do
      {:error, :enotsup} -> false
      _                  -> true
    end
  end

  @doc """
  The maximum number of symlinks allowed to be followed in the resolution
  of a given path.

  In order to provide portable BEAM files, this limit is approximated.  For
  Windows based systems which support symbolic links, this is always 63.
  Otherwise, 64 was chosen as double the largest known value (32 on Darwin)
  to allow for error.

  On systems which do not support symbolic links, this function will always
  return 0.
  """
  def maxsymlinks() do
    # Windows is known to allow 63 reparse points:
    #   https://msdn.microsoft.com/en-us/library/windows/desktop/aa365503%28v=vs.85%29.aspx
    #
    # Unix limit should be obtained via:
    #   - limits.h:     SYMLINK_MAX    Cygwin
    #   - sys/param.h:  MAXSYMLINKS    Solaris
    # At this time, the largest value I have found is 32 (darwin).  Setting
    # it to 64 should leave space for error.
    #
    # See canon_path/doc/symloop_max.c for example C program for determining
    # this value.
    #
    # Unfortunately, doing this at compile time would prevent generated BEAM
    # files from being portable.

    if OSUtils.supports_symlinks? do
      case OSUtils.os_id do
        :win32 -> 63
        _      -> 64
      end
    else
      0
    end
  end

end
