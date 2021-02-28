import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    placeholder: "Click and type to search"
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };