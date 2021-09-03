# Kubex

Compile with:
```elixir
mix escript.build
```

Commands:

Sort all the cluster pods per memory or cpu and display also the node they are in.
```elixir
./kubex pods --sort-by="memory"
./kubex pods --sort-by="cpu"
```

Sort all the cluster services per memory or cpu and display also the node they are in.
```elixir
./kubex services --sort-by="memory"
./kubex services --sort-by="cpu"
```
