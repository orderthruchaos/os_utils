defmodule OSUtilsTest do
  use ExUnit.Case
  alias OSUtils, as: OU


  test "is windows?" do
    case :os.type do
      {:win32, _} -> assert OU.is_win?
      _           -> refute OU.is_win?
    end
  end

  test "is unix?" do
    case :os.type do
      {:unix, _} -> assert OU.is_unix?
      _          -> refute OU.is_unix?
    end
  end

  # Note:  needs tested on OSE.
  test "is ose?" do
    case :os.type do
      {:ose, _} -> assert OU.is_ose?
      _         -> refute OU.is_ose?
    end
  end

  # Note:  needs tested on OSE.
  test "os id" do
    { os, _ } = :os.type
    assert os == OU.os_id
  end

  # Note:  needs tested on OSE.
  test "OS name" do
    { _, name } = :os.type
    assert name == OU.os_name
  end

  # TODO:  Test on system without symlink support.
  test "has symlinks?" do
    case :file.read_link(Path.expand(__ENV__.file)) do
      {:error, :enotsup} -> refute OU.supports_symlinks?
      _                  -> assert OU.supports_symlinks?
    end
  end

end
