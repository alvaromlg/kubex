# Kubex

Compile with:
```elixir
mix escript.build
```

Commands:

Sort all the cluster pods per memory or cpu and display also the node they are in.
```elixir
./kubex info --sort-by="memory"
./kubex info --sort-by="cpu"
```
