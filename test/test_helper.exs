has_symlinks = case :file.read_link(Path.expand(__ENV__.file)) do
  {:error, :enotsup} -> false
  _                  -> true
end

{ incl_symlinks_str, tags_to_exclude } =
if has_symlinks do
  { "has_symlinks", [:todo, :os, :os_sym, :no_symlinks] }
else
  { "no_symlinks", [:todo, :os, :os_sym, :has_symlinks] }
end

{ this_os, _ } = :os.type
os_sym_tag     = :"#{this_os}_#{incl_symlinks_str}"


ExUnit.configure(
  exclude: tags_to_exclude,
  include: [os: this_os, os_sym: os_sym_tag] )


ExUnit.start()
