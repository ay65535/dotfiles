# apt list uv
# -

brew info uv
# ==> uv: stable 0.6.14 (bottled), HEAD

mise plugins ls-remote | grep uv
mise ls-remote uv
# 0.6.14

mise install uv
mise use --global uv

which -a uv
uv --version
