<script>
  let title = ''
  let details = ''
  let result = null

  async function createTodo () {
    const res = await fetch(`http://localhost:8081/todo`, {
      method: 'POST',
      body: JSON.stringify({
        title
      }),
      headers: {
        "content-type": "application/json"
      }
    })

    const json = await res.json()
    result = JSON.stringify(json)
  }
</script>


<input bind:value={title} />
<input bind:value={details} />
<button type="button" on:click={createTodo}>
  Post it.
</button>
