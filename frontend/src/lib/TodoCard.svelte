<script>
  import { todosRefreshTime } from '../stores.js'
  import { dateDiffHuman } from '../dateDiffHuman.js';

  export let todo;

  async function resolve(todo) {
    const res = await fetch(`http://localhost:8081/todo/` + todo.pk + `/resolve`, {
      method: 'PUT'
    })
    const data = await res.json()

    if (res.ok) {
      todosRefreshTime.set(Date.now())
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
      todosRefreshTime.set(Date.now())
    } else {
      throw new Error(data);
    }
  }
</script>

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

  {#if todo.details}
  <div class="card-content">
    <span class="details">{todo.details}</span>
  </div>
  {/if}
</div>
