<script>
  import { todosRefreshTime, todos } from '../stores.js'

  let promise = fetchTodosList();

  async function fetchTodosList() {
    const res = await fetch(`http://localhost:8081/todos`);
    const data = await res.json();

    if (res.ok) {
      todos.set(data.todos)
    } else {
      throw new Error(data);
    }
  }

  todosRefreshTime.subscribe((value) => fetchTodosList())
</script>

<h2>Current Todos</h2>

{#each $todos as todo, i}
  <div class="card">
    <span class="created">{todo.created_at}</span>
    <span class="resolved">{todo.resolved_at}</span>
    <span class="title">{todo.title}</span>
    <span class="details">{todo.details}</span>
  </div>
{/each}

<style>
.card {
  background: #eee;
  transition: background-color 0.5s;
}

.card:hover {
  background-color: #aaa;
  transition: background-color 0.5s;
}
</style>
