# ~/.profile.d/chefdk.sh - Setup Chef development kit.
# NOTE: This uses pathmunge

for chefroot in "/opt/chefdk" \
    "/cygdrive/c/devel/chefdk"; do

    if [ -d "$chefroot" ] && [ -x "$chefroot/bin/chef" ] ; then
        pathmunge $chefroot/bin after
        pathmunge $chefroot/embedded/bin after
        pathmunge ~/.chefdk/gem/ruby/2.5.0/bin after

        GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.5.0"
        GEM_HOME="$HOME/.chefdk/gem/ruby/2.5.0"
        GEM_PATH="$HOME/.chefdk/gem/ruby/2.5.0:/opt/chefdk/embedded/lib/ruby/gems/2.5.0"

        export PATH GEM_ROOT GEM_HOME GEM_PATH
        # Break on first found
        break
    fi
done
builtin unset -v chefroot


# vim:set ft=zsh:
