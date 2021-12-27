# Test that the theming app works as expected

    Code
      pickerInput("test_id", "Test", choices = c("A", "B"))
    Output
      <div class="form-group shiny-input-container">
        <label class="control-label" for="test_id">Test</label>
        <select id="test_id" class="selectpicker form-control"><option value="A">A</option>
      <option value="B">B</option></select>
      </div>

