(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: shedelin <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/27 12:49:05 by shedelin          #+#    #+#             *)
(*   Updated: 2015/06/27 12:49:07 by shedelin         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)


let locale = GtkMain.Main.init ()

let loop_tama stats =
	
	let window = GWindow.window ~width:1024 ~height:720
								~title:"Instant tama : kyubey" () in

	let vbox = GPack.vbox ~packing:window#add () in
	ignore(window#connect#destroy ~callback:GMain.Main.quit);

	(* Menu bar *)
	let menubar = GMenu.menu_bar ~packing:vbox#pack () in
	let factory = new GMenu.factory menubar in
	let accel_group = factory#accel_group in
	let file_menu = factory#add_submenu "File" in

	let appli_box = GPack.vbox ~packing:vbox#add () in

		let prog_bars = GPack.hbox ~packing:appli_box#add () in

			let health_bar = GPack.table ~rows:3 ~columns:2 ~packing:prog_bars#add () in
				let health_prog = GRange.progress_bar ~pulse_step:0.01 () ~packing:(health_bar#attach ~left:0 ~right:2 ~top:1 ~expand:`BOTH ~fill:`X ~shrink:`BOTH) in
				health_prog#set_text "Health";

		 	let energy_bar = GPack.table ~rows:3 ~columns:2 ~packing:prog_bars#add () in
				let energy_prog = GRange.progress_bar ~pulse_step:0.01 () ~packing:(energy_bar#attach ~left:0 ~right:2 ~top:1 ~expand:`BOTH ~fill:`X ~shrink:`BOTH) in
				energy_prog#set_text "Energy";


		 	let hygien_bar = GPack.table ~rows:3 ~columns:2 ~packing:prog_bars#add () in
				let hygien_prog = GRange.progress_bar ~pulse_step:0.01 () ~packing:(hygien_bar#attach ~left:0 ~right:2 ~top:1 ~expand:`BOTH ~fill:`X ~shrink:`BOTH) in
				hygien_prog#set_text "Hygiene";

		 	let happy_bar = GPack.table ~rows:3 ~columns:2 ~packing:prog_bars#add () in
				let happy_prog = GRange.progress_bar ~pulse_step:0.01 () ~packing:(happy_bar#attach ~left:0 ~right:2 ~top:1 ~expand:`BOTH ~fill:`X ~shrink:`BOTH) in
				happy_prog#set_text "Happiness";


	
	let box_img = GMisc.image ~file:"img/kyubeyNormal.png" ~packing:appli_box#add () in	

	let action_bar = GPack.hbox ~height:50 ~packing:appli_box#pack () in

		let button_eat = GButton.button ~label:"EAT"
									~packing:action_bar#add () in
		ignore(button_eat#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeyEat.jpg";
					stats#do_eat ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));
		
		let button_thunder = GButton.button ~label:"THUNDER"
									~packing:action_bar#add () in
		ignore(button_thunder#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeyAttack.jpg";
					stats#do_thunder ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));
		
		let button_bath = GButton.button ~label:"BATH"
									~packing:action_bar#add () in
		ignore(button_bath#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeybath.jpg";
					stats#do_bath ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));
		
		let button_kill = GButton.button ~label:"KILL"
									~packing:action_bar#add () in
		ignore(button_kill#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeykill.png";
					stats#do_kill ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));

		let button_sleep = GButton.button ~label:"SLEEP"
									~packing:action_bar#add () in
		ignore(button_sleep#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeysleep.jpg";
					stats#do_sleep ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));

		let button_dance = GButton.button ~label:"DANCE"
									~packing:action_bar#add () in
		ignore(button_dance#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeydance.jpg";
					stats#do_sleep ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));

		let button_hide = GButton.button ~label:"HIDE"
									~packing:action_bar#add () in
		ignore(button_hide#connect#clicked ~callback: (fun () -> 
			if (stats#is_alive) then
				begin
					box_img#set_file "img/kyubeyhide.jpg";
					stats#do_hide ()
				end
			else
				box_img#set_file "img/gameover.jpg"
			));

	ignore(GMain.Timeout.add ~ms:50 ~callback:(fun () -> 
		if not (stats#is_alive) then box_img#set_file "img/gameover.jpg";
		health_prog#set_fraction stats#getHealth;
		energy_prog#set_fraction stats#getEnergy;
		hygien_prog#set_fraction stats#getHygiene;
		happy_prog#set_fraction stats#getHappiness
	; true));

	ignore(GMain.Timeout.add ~ms:1000 ~callback:(fun () -> 
		if (stats#is_alive) then
					stats#do_loss_health ()
			else
				box_img#set_file "img/gameover.jpg"
	; true));

	(* File menu *)
	let factory = new GMenu.factory file_menu ~accel_group in
	ignore(factory#add_item "Save" ~key:GdkKeysyms._S ~callback: (fun () -> stats#save_tama ()));
	ignore(factory#add_item "Restart" ~key:GdkKeysyms._R ~callback: (fun () -> box_img#set_file "img/kyubeyNormal.png";stats#restart ()));
	ignore(factory#add_item "Load" ~key:GdkKeysyms._S ~callback: (fun () -> stats#load_tama (); box_img#set_file "img/kyubeyNormal.png"));
	ignore(factory#add_item "Quit" ~key:GdkKeysyms._Q ~callback: GMain.Main.quit);

	window#add_accel_group accel_group;
	window#show ();
	GMain.Main.main ()

let () = 	
	let stats = new Action.perform in
	loop_tama stats
