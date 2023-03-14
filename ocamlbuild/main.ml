let s = input_line (open_in "res/grayscale_70_levels.txt");;
let sl = 70;;
let image_side = 28;;

let map_int (i: int) (r1: int) (r2: int) : int =
  int_of_float ((float_of_int i /. (float_of_int r1)) *. float_of_int r2)
let print_image (image : int array) : unit =
  for i = 0 to image_side - 1 do(
    for j = 0 to image_side - 1 do
      print_char (s.[map_int image.(i*image_side + j) 256 70])
    done;
      print_char '\n')
  done;;

let main (_ : unit) : unit =
  let train_images = Mnist.open_in "res/data/train-images-idx3-ubyte" in (* 60000 *)
  let train_labels = Mnist.open_in "res/data/train-labels-idx1-ubyte" in
  let test_images = Mnist.open_in "res/data/t10k-images-idx3-ubyte" in
  let nbr_test_images = 1000 in
  let nbr_train_images = 1100 in
  let test_labels = Mnist.open_in "res/data/t10k-labels-idx1-ubyte" in
  let se = Knn.mnist_seq nbr_train_images train_images train_labels in
  let a = ref 0 in
  for k = 0 to nbr_test_images - 1 do
  if Knn.classify 3 se (Mnist.get test_images k) = (Mnist.get test_labels k).(0) then
    a := !a + 1
  done;
  print_float ( 100. *. (float_of_int !a) /. float_of_int nbr_test_images);
  print_newline ()

let _ : unit =
  main ()
