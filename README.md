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

![alt text](https://github.com/alvaromlg/kubex/blob/master/readme/pods_output.png)

Sort all the cluster services per memory or cpu and display also the node they are in.
```elixir
./kubex services --sort-by="memory"
./kubex services --sort-by="cpu"
```

![alt text](https://github.com/alvaromlg/kubex/blob/master/readme/services_output.png)
