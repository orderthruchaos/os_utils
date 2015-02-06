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
  @tag :no_symlinks
  test "has symlinks? (no)" do
    refute OU.supports_symlinks?
  end


  @tag :has_symlinks
  test "has symlinks? (yes)" do
    assert OU.supports_symlinks?
  end

  @tag :no_symlinks
  test "maxsymlinks output (no symlinks)" do
    assert 0 == OU.maxsymlinks()
  end

  @tag :has_symlinks
  test "maxsymlinks output (has symlinks)" do
    expected = case OU.os_id do
      :win32 -> 63
      _      -> 64
    end

    assert expected == OU.maxsymlinks()
  end
  
end
