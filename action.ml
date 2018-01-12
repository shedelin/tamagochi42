
module type ACTION =
sig
	type state = {
		health: float;
		energy: float;
		hygiene: float;
		happiness: float
	}

	val add : float -> float -> float
	val sub : float -> float -> float
	val feed : float -> float -> float -> float -> state
	val change : state -> state
	val health : state -> float
	val energy : state -> float
	val hygiene : state -> float
	val happiness : state -> float
	val is_alive : state -> bool
end

module Common =
struct
	type state = {
		health: float;
		energy: float;
		hygiene: float;
		happiness: float
	}
	let add a b = if ((a +. b) > 1.) then 1. else a +. b
	let sub a b = if ((a -. b) <= 0.) then 0. else a -. b

	let feed health energy hygiene happiness = {health = health; energy = energy; hygiene = hygiene; happiness = happiness}

	let health {health = health; energy = _; hygiene = _; happiness = _} = health
	let energy {health = _; energy = energy; hygiene = _; happiness = _} = energy
	let hygiene {health = _; energy = _; hygiene = hygiene; happiness = _} = hygiene
	let happiness {health = _; energy = _; hygiene = _; happiness = happiness} = happiness

	let is_alive {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		if (health = 0.) then false
		else if (energy = 0.) then false
		else if (hygiene = 0.) then false
		else if (happiness = 0.) then false
		else true
end

module Eat =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = add health 0.25; energy = sub energy 0.1; hygiene = sub hygiene 0.2; happiness = add happiness 0.5}
end

module Thunder =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = sub health 0.2; energy = add energy 0.25; hygiene = hygiene; happiness = sub happiness 0.2}
end

module Bath =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = sub health 0.2; energy = sub energy 0.1; hygiene = add hygiene 0.25; happiness = add happiness 0.5}
end

module Kill =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = sub health 0.2; energy = sub energy 0.1; hygiene = hygiene; happiness = add happiness 0.2}
end

module Sleep =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = health; energy = energy; hygiene = hygiene; happiness = happiness}
end

module Dance =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = health; energy = energy; hygiene = hygiene; happiness = happiness}
end

module Hide =
struct
	include Common

	let change {health = health; energy = energy; hygiene = hygiene; happiness = happiness} =
		{health = health; energy = energy; hygiene = hygiene; happiness = happiness}
end

module Perform =
	functor (Action : ACTION) ->
		struct

			let health state = Action.health state
			let energy state = Action.energy state
			let hygiene state = Action.hygiene state
			let happiness state = Action.happiness state
			let is_alive state = Action.is_alive state
			let feed health energy hygiene happiness = Action.feed health energy hygiene happiness
			let stats old = Action.change old
	
		end

module Do_eat = Perform(Eat)
module Do_thunder = Perform(Thunder)
module Do_bath = Perform(Bath)
module Do_kill = Perform(Kill)
module Do_sleep = Perform(Sleep)
module Do_dance = Perform(Dance)
module Do_hide = Perform(Hide)

let intial = (1., 1., 1., 1.)

class perform =
	object (self)
		val mutable _health:float = 1.
		val mutable _energy:float = 1.
		val mutable _hygiene:float = 1.
		val mutable _happiness:float = 1.
		val mutable _is_alive:bool = true

		method do_eat () =
			let old_stats = Do_eat.feed _health _energy _hygiene _happiness in
			let new_stats = Do_eat.stats old_stats in
				_health <- Do_eat.health new_stats;
				_energy <- Do_eat.energy new_stats;
				_hygiene <- Do_eat.hygiene new_stats;
				_happiness <- Do_eat.happiness new_stats;
				_is_alive <- Do_eat.is_alive new_stats

		method do_thunder () =
			let old_stats = Do_thunder.feed _health _energy _hygiene _happiness in
			let new_stats = Do_thunder.stats old_stats in
				_health <- Do_thunder.health new_stats;
				_energy <- Do_thunder.energy new_stats;
				_hygiene <- Do_thunder.hygiene new_stats;
				_happiness <- Do_thunder.happiness new_stats;
				_is_alive <- Do_thunder.is_alive new_stats

		method do_bath () =
			let old_stats = Do_bath.feed _health _energy _hygiene _happiness in
			let new_stats = Do_bath.stats old_stats in
				_health <- Do_bath.health new_stats;
				_energy <- Do_bath.energy new_stats;
				_hygiene <- Do_bath.hygiene new_stats;
				_happiness <- Do_bath.happiness new_stats;
				_is_alive <- Do_bath.is_alive new_stats

		method do_kill () =
			let old_stats = Do_kill.feed _health _energy _hygiene _happiness in
			let new_stats = Do_kill.stats old_stats in
				_health <- Do_kill.health new_stats;
				_energy <- Do_kill.energy new_stats;
				_hygiene <- Do_kill.hygiene new_stats;
				_happiness <- Do_kill.happiness new_stats;
				_is_alive <- Do_kill.is_alive new_stats

		method do_sleep () =
			let old_stats = Do_sleep.feed _health _energy _hygiene _happiness in
			let new_stats = Do_sleep.stats old_stats in
				_health <- Do_sleep.health new_stats;
				_energy <- Do_sleep.energy new_stats;
				_hygiene <- Do_sleep.hygiene new_stats;
				_happiness <- Do_sleep.happiness new_stats;
				_is_alive <- Do_sleep.is_alive new_stats

		method do_dance () =
			let old_stats = Do_dance.feed _health _energy _hygiene _happiness in
			let new_stats = Do_dance.stats old_stats in
				_health <- Do_dance.health new_stats;
				_energy <- Do_dance.energy new_stats;
				_hygiene <- Do_dance.hygiene new_stats;
				_happiness <- Do_dance.happiness new_stats;
				_is_alive <- Do_dance.is_alive new_stats

		method do_hide () =
			let old_stats = Do_hide.feed _health _energy _hygiene _happiness in
			let new_stats = Do_hide.stats old_stats in
				_health <- Do_hide.health new_stats;
				_energy <- Do_hide.energy new_stats;
				_hygiene <- Do_hide.hygiene new_stats;
				_happiness <- Do_hide.happiness new_stats;
				_is_alive <- Do_hide.is_alive new_stats

		method do_loss_health () =
			_health <- Common.sub _health 0.01;
			let old_stats = Do_kill.feed _health _energy _hygiene _happiness in
			_is_alive <- Do_eat.is_alive old_stats

		method is_alive = _is_alive
		method getHealth = _health
		method getEnergy = _energy
		method getHygiene = _hygiene
		method getHappiness = _happiness
	
		method save_tama () = 
			let oc = open_out "save.itama" in
			output_string oc ((string_of_float _health) ^ "\n");
			output_string oc ((string_of_float _hygiene) ^ "\n");
			output_string oc ((string_of_float _energy) ^ "\n");
			output_string oc ((string_of_float _happiness) ^ "\n");
			close_out oc

		method restart () =
			_health <- 1.;
			_hygiene <- 1.;
			_energy <- 1.;
			_happiness <- 1.;
			_is_alive <- true 

		method private read =
				try
					let ic = open_in "save.itama" in
					let rec read_line l =
						try
							let line = input_line ic in
							(float_of_string line)::(read_line l)
						with
						| _ -> close_in ic; l
					in
					read_line []
				with
				| _ -> print_endline "file: save.itama dont exist"; []

		method load_tama () =
			let lst = self#read in
			if (lst <> []) then begin
				_health <- List.nth lst 0;
				_hygiene <- List.nth lst 1;
				_energy <- List.nth lst 2;
				_happiness <- List.nth lst 3;
				if not (_health = 0. || _hygiene = 0. || _energy = 0. || _happiness = 0.)
					then _is_alive <- true
				else _is_alive <- false 

			end
	end





