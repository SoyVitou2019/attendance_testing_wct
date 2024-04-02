<form action="{{ route("positions.store") }}" method="POST">
    @csrf
    <input type="text" name="position_title" placeholder="Position Title" class="d-block w-50 my-3 ">
    @error('position_title')
        <p>{{ $message }}</p>
    @enderror
    <button class="btn btn-dark" type='submit'> Create </button>
</form>
