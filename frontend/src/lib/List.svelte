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

  async function resolve(todo) {
    const res = await fetch(`http://localhost:8081/todo/` + todo.pk + `/resolve`, {
      method: 'PUT'
    })
    const data = await res.json()

    if (res.ok) {
      await fetchTodosList()
    } else {
      throw new Error(data);
    }
  }

  async function unresolve(todo) {
    const res = await fetch(`http://localhost:8081/todo/` + todo.pk + `/unresolve`, {
      method: 'PUT'
    })
    const data = await res.json()

    if (res.ok) {
      await fetchTodosList()
    } else {
      throw new Error(data);
    }
  }

  function dateDiffHuman(datetime) {
    let now = Date.now()
    let then = Date.parse(datetime)

    let d1 = new Date()
    let tz_offset = d1.getTimezoneOffset() * 60

    seconds = (now - then) / 1000 + tz_offset

    function numberEnding (number) {
        return (number > 1) ? 's' : '';
    }

    var years = Math.floor(seconds / 31536000);
    if (years) {
        return years + ' year' + numberEnding(years);
    }
    //TODO: Months! Maybe weeks?
    var days = Math.floor((seconds %= 31536000) / 86400);
    if (days) {
        return days + ' day' + numberEnding(days);
    }
    var hours = Math.floor((seconds %= 86400) / 3600);
    if (hours) {
        return hours + ' hour' + numberEnding(hours);
    }
    var minutes = Math.floor((seconds %= 3600) / 60);
    if (minutes) {
        return minutes + ' minute' + numberEnding(minutes);
    }
    var seconds = seconds % 60;
    if (seconds) {
        return 'seconds';
    }
    return 'seconds';
  }

  todosRefreshTime.subscribe((value) => fetchTodosList())
</script>

<h2>Current Todos</h2>

{#each $todos as todo, i}
  <div class="card">
    <span class="card-title">{todo.title}</span>

    <span class="created">{dateDiffHuman(todo.created_at)} ago</span>

    {#if Date.parse(todo.resolved_at) != Date.parse("1970-01-01")}
      <span class="resolved">{dateDiffHuman(todo.resolved_at)} ago</span>
    {/if}

    {#if Date.parse(todo.resolved_at) == Date.parse("1970-01-01")}
      <button class="btn-small right" on:click={() => resolve(todo)}><i class="material-icons">check</i></button>
    {:else}
      <button class="btn-small right" on:click={() => unresolve(todo)}><i class="material-icons">restore</i></button>
    {/if}

    <div class="card-content">
      <span class="details">{todo.details}</span>
    </div>
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
