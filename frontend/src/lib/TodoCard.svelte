<script>
  import { todosRefreshTime } from '../stores.js'
  import { dateDiffHuman } from '../dateDiffHuman.js';

  import { api } from '../api.js'

  export let todo;

  async function resolve(todo) {
    const res = await fetch(api + `/todo/` + todo.pk + `/resolve`, {
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
    const res = await fetch(api + `/todo/` + todo.pk + `/unresolve`, {
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

<div class="card hoverable {Date.parse(todo.resolved_at) != Date.parse("1970-01-01T00:00") ? 'grey' : 'yellow'} lighten-4">
  <div class="card-header row">
    <div class="card-title col s11">
      {todo.title}

      {#if Date.parse(todo.resolved_at) != Date.parse("1970-01-01T00:00")}
        <span class="badge grey-text text-darken-1">
          resolved {dateDiffHuman(todo.resolved_at)} ago
        </span>
      {/if}

      <span class="badge grey-text text-darken-1">
        created {dateDiffHuman(todo.created_at)} ago
      </span>
    </div>

    <div class="col s1">
      {#if Date.parse(todo.resolved_at) == Date.parse("1970-01-01T00:00")}
        <button class="btn-small right" on:click={() => resolve(todo)}><i class="material-icons">check</i></button>
      {:else}
        <button class="btn-small right" on:click={() => unresolve(todo)}><i class="material-icons">restore</i></button>
      {/if}
    </div>
  </div>






  {#if todo.details}
    <p class="grey-text text-darken-4">
      {todo.details}
    </p>
  {/if}

  {#if Date.parse(todo.resolved_at) != Date.parse("1970-01-01T00:00")}
  <div class="progress">
    <div class="determinate" style="width: {todo.ttl_left_percentage}%"></div>
  </div>
  {/if}
</div>

<style>
  .card {
    padding: 1em;
  }
</style>
