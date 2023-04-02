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
  let train_labels = Mnist.open_in "res/data/train-labels-idx1-ubyte" in (* 60000 *)
  let test_images = Mnist.open_in "res/data/t10k-images-idx3-ubyte" in (* 10000 *)
  let test_labels = Mnist.open_in "res/data/t10k-labels-idx1-ubyte" in (* 10000 *)
  let nbr_test_images = 400 in
  let nbr_train_images = 1000 in
  print_string "Sucess rate Knn: ";
  print_float (Knn.error_rate nbr_train_images 
      nbr_test_images train_images test_images train_labels test_labels 3);
  print_string " %";
  print_newline ()

let _ : unit =
  main ()
