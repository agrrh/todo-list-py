<script>
  import TodoForm from './lib/Form.svelte'
  import TodoList from './lib/List.svelte'
</script>

<main>
  <h1 class="title">Todo List Python</h1>

  <div class="section">
    <TodoForm />
  </div>

  <div class="section">
    <TodoList />
  </div>
</main>

<style>
  .title:hover {
    text-shadow: 0 0 2px #aaaaaa;
  }
</style>
