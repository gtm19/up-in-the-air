import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

const initSelect2 = () => {
  $('.select2').select2({
    placeholder: "Click and type to search",
    width: "100%"
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };
