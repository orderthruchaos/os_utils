has_symlinks = case :file.read_link(Path.expand(__ENV__.file)) do
  {:error, :enotsup} -> false
  _                  -> true
end

if has_symlinks do
  incl_symlinks_str = "has_symlinks"
  tags_to_exclude = [:todo, :os, :os_sym, :no_symlinks]
else
  incl_symlinks_str = "no_symlinks"
  tags_to_exclude = [:todo, :os, :os_sym, :has_symlinks]
end

{ this_os, _ } = :os.type
os_sym_tag     = :"#{this_os}_#{incl_symlinks_str}"


ExUnit.configure(
  exclude: tags_to_exclude,
  include: [os: this_os, os_sym: os_sym_tag] )


ExUnit.start()
