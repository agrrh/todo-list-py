<script>
  import { todosRefreshTime, todos } from '../stores.js'
  import { poll } from '../poll.js';

  import { api } from '../api.js'

  import TodoCard from './TodoCard.svelte'

  let promise = fetchTodosList();

  async function fetchTodosList() {
    const res = await fetch(api + `/todos`);
    const data = await res.json();

    if (res.ok) {
      todos.set(data.todos)
    } else {
      throw new Error(data);
    }
  }

  // Fetch every 5 seconds
  poll(fetchTodosList, 5000);

  todosRefreshTime.subscribe((value) => fetchTodosList())
</script>

{#each $todos as todo, i}
  <TodoCard todo={todo} />
{/each}
