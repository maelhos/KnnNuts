


(** Type interne à ce module pour représenter ses données d'entrainement.
    Dans la partie sans prétraitement, on choisit simplement la séquence des
    couples (donnée, étiquette).
    Dans la partie avec arbre k-d, ce sera un arbre dimensionnel. *)

    val count_item : 'a Seq.t -> 'a -> int

    val most_frequent : 'a list -> 'a
    
    val euclidean_dist : int array -> int array -> float
    
    val mnist_seq : int -> Mnist.idx -> Mnist.idx -> (int array * int) Seq.t
    
    (** Initialisation des données d'entrainement *)
    val init : (int array * 'label) Seq.t -> (int array * 'label) Seq.t
    
    (** Classification d'une donnée *)
    val classify : int -> (int array * 'label) Seq.t -> int array -> 'label 