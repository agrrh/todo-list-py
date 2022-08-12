<script>
  import Form from './lib/Form.svelte'
  import List from './lib/List.svelte'
</script>

<main>
  <h1 class="title">Todo List Python</h1>

  <div class="section">
    <Form />
  </div>

  <div class="section">
    <List />
  </div>
</main>

<style>
  .title:hover {
    text-shadow: 0 0 2px #aaaaaa;
  }
</style>
