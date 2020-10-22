(** [t] is a vector with x-position [x], y-position [y], 
    and z-position [z]. *)
type t = {x : float; y : float; z : float}

(** [create x y z] is the vector with coordinates [x], [y], and [z]*)
val create : float -> float -> float -> t 

(** [get_x t] is the x coordinate of vector [t] *)
val get_x : t -> float 

(** [get_y t] is the y coordinate of vector [t] *)
val get_y : t -> float 

(** [get_z t] is the z coordinate of vector [t] *)
val get_z : t -> float

(** [ - t1 t2] is the vector difference of vector [t1] minus vector [t2]. *)
val ( - ) : t -> t -> t

(** [ + t1 t2] is the vector sum of vector [t1] plus vector [t2]. *)
val ( + ) : t -> t -> t 

(** [ * t1 t2] is the vector product of vector [t1] and vector [t2]. *)
val ( * ) : t -> t -> t

(** [mult_constant t c] is a vector after each coordinate has been divided by a 
    constant factor c *)
val div_constant : t -> float -> t 

(** [mult_constant t c] is a vector after each coordinate has been 
    multiplied by a constant factor c *)
val mult_constant : t -> float -> t 

(** [dot_prod t1 t2] is the dot product of the vectors [t1] and [t2]*)
val dot_prod : t -> t -> float 

(** [cross_produ t1 t2] is the cross product of the vectors [t1] and [t2]*)
val cross_prod : t -> t -> float 

(** [length t] is the length, or norm, of [t] *)
val length : t -> float 

(** [unit_vector t] is the unit vector (vector with magnitude 1
    and direction) of [t] *)
val unit_vector : t -> t

(** [random_unit_vector t] is a unit vector with a randomly
    generated direction using an equal-area projection model to ensure
    randomness in 3D space. *)
val random_unit_vector : unit -> t