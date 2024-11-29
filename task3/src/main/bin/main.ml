let s_Andrey = 7293260.;;
let s_0_Andrey = 1108129.;;
let s_Ivan = 14200000.;;
let s_0_Ivan = 4000000.;;

let r_Andrey = 29.2;;
let r_Ivan = 30.;;

let n_20 = 20.;;
let n_30 = 30.;;

let folder = "calculations/";;
let f_ann_20_Andrey =
    String.cat folder "annuitet_20_Andrey.csv"
let f_dif_20_Andrey =
    String.cat folder "differential_20_Andrey.csv"
let f_ann_30_Andrey =
    String.cat folder "annuitet_30_Andrey.csv"
let f_dif_30_Andrey =
    String.cat folder "differential_30_Andrey.csv"
let f_ann_20_Ivan =
    String.cat folder "annuitet_20_Ivan.csv"
let f_dif_20_Ivan =
    String.cat folder "differential_20_Ivan.csv"
let f_ann_30_Ivan =
    String.cat folder "annuitet_30_Ivan.csv"
let f_dif_30_Ivan =
    String.cat folder "differential_30_Ivan.csv"


let calc_S s s_0 =
    ( -.) s s_0

let calc_r r =
    ( /. ) (( /. ) r 100.) 12.

let calc_n n =
    ( *. ) n 12.

let calc_A s r n =
    Float.round (( *. ) s (( /. ) (( *. ) r (( ** ) (( +. ) 1. r) n)) (( -. ) (( ** ) (( +. ) 1. r) n) 1.)))

let rec write_to_file_ann oc month s a percent dif n r total_paid overpayment =
    if month > n then
        Printf.fprintf oc "Упл. всего (р.),%.0f,,,\nОбщ. перепл. (р.),%.0f,,," total_paid overpayment
	else if month <= 5. || month > (( -. ) n 5.) then
        begin
            Printf.fprintf oc "%.0f,%.0f,%.0f,%.0f,%.0f\n" month s a percent dif;
            let month = (( +. ) month 1.) in
                let total_paid = (( +. ) total_paid a) in
                    let s = (calc_S s dif) in
                        let overpayment = (( +. ) overpayment percent) in
                            let percent = (( *. ) s r) in
                                let dif = (( -. ) a percent) in
                                    write_to_file_ann oc month s a percent dif n r total_paid overpayment
        end
    else if month = (( /. ) n 2.) then
        begin
            Printf.fprintf oc "..,..,..,..,..\n";
            let month = (( +. ) month 1.) in
                let total_paid = (( +. ) total_paid a) in
                    let s = (calc_S s dif) in
                        let overpayment = (( +. ) overpayment percent) in
                            let percent = (( *. ) s r) in
                                let dif = (( -. ) a percent) in
                                    write_to_file_ann oc month s a percent dif n r total_paid overpayment
        end    
    else (
        let month = (( +. ) month 1.) in
            let total_paid = (( +. ) total_paid a) in
                let s = (calc_S s dif) in
                    let overpayment = (( +. ) overpayment percent) in
                        let percent = (( *. ) s r) in
                            let dif = (( -. ) a percent) in
                                write_to_file_ann oc month s a percent dif n r total_paid overpayment
        )          

let calc_D dif s r =
    let s_d = (( *. ) s r) in
        Float.round (( +. ) dif s_d)

let rec write_to_file_dif oc month s d percent dif n r total_paid overpayment =
    if month > n then
        Printf.fprintf oc "Упл. всего (р.),%.0f,,,\nОбщ. перепл. (р.),%.0f,,," total_paid overpayment
	else if month <= 5. || month > (( -. ) n 5.) then
        begin
            Printf.fprintf oc "%.0f,%.0f,%.0f,%.0f,%.0f\n" month s d percent dif;
            let month = (( +. ) month 1.) in
                let total_paid = (( +. ) total_paid d) in
                    let s = (calc_S s dif) in
                        let overpayment = (( +. ) overpayment percent) in
                            let percent = (( *. ) s r) in
                                let d = (( +. ) dif percent) in
                                    write_to_file_dif oc month s d percent dif n r total_paid overpayment
        end
    else if month = (( /. ) n 2.) then
        begin
            Printf.fprintf oc "..,..,..,..,..\n";
            let month = (( +. ) month 1.) in
                let total_paid = (( +. ) total_paid d) in
                    let s = (calc_S s dif) in
                        let overpayment = (( +. ) overpayment percent) in
                            let percent = (( *. ) s r) in
                                let d = (( +. ) dif percent) in
                                    write_to_file_dif oc month s d percent dif n r total_paid overpayment
        end
    else (
        let month = (( +. ) month 1.) in
            let total_paid = (( +. ) total_paid d) in
                let s = (calc_S s dif) in
                    let overpayment = (( +. ) overpayment percent) in
                        let percent = (( *. ) s r) in
                            let d = (( +. ) dif percent) in
                                write_to_file_dif oc month s d percent dif n r total_paid overpayment
    ) 			

let () =
    let oc = open_out f_ann_20_Andrey in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_20) in
                let r_temp = (calc_r r_Andrey) in
                    let s_temp = (calc_S s_Andrey s_0_Andrey) in
                        let a_temp = (calc_A s_temp r_temp n_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) a_temp percent_temp) in
                                    write_to_file_ann oc month_temp s_temp a_temp percent_temp dif_temp n_temp r_temp 0. 0.;
    close_out oc;
    let oc = open_out f_dif_20_Andrey in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_20) in
                let r_temp = (calc_r r_Andrey) in
                    let s_temp = (calc_S s_Andrey s_0_Andrey) in
                        let d_temp = (calc_D (( /. ) s_temp n_temp) s_temp r_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( /. ) s_temp n_temp) in
                                    write_to_file_dif oc month_temp s_temp d_temp percent_temp dif_temp n_temp r_temp 0. 0.;
		close_out oc;
    let oc = open_out f_ann_30_Andrey in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_30) in
                let r_temp = (calc_r r_Andrey) in
                    let s_temp = (calc_S s_Andrey s_0_Andrey) in
                        let a_temp = (calc_A s_temp r_temp n_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) a_temp percent_temp) in
                                    write_to_file_ann oc month_temp s_temp a_temp percent_temp dif_temp n_temp r_temp 0. 0.;
    close_out oc;
    let oc = open_out f_dif_30_Andrey in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_30) in
                let r_temp = (calc_r r_Andrey) in
                    let s_temp = (calc_S s_Andrey s_0_Andrey) in
                        let d_temp = (calc_D (( /. ) s_temp n_temp) s_temp r_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( /. ) s_temp n_temp) in
                                    write_to_file_dif oc month_temp s_temp d_temp percent_temp dif_temp n_temp r_temp 0. 0.;
		close_out oc;
    let oc = open_out f_ann_20_Ivan in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_20) in
                let r_temp = (calc_r r_Ivan) in
                    let s_temp = (calc_S s_Ivan s_0_Ivan) in
                        let a_temp = (calc_A s_temp r_temp n_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) a_temp percent_temp) in
                                    write_to_file_ann oc month_temp s_temp a_temp percent_temp dif_temp n_temp r_temp 0. 0.;
    close_out oc;
    let oc = open_out f_dif_20_Ivan in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_20) in
                let r_temp = (calc_r r_Ivan) in
                    let s_temp = (calc_S s_Ivan s_0_Ivan) in
                        let d_temp = (calc_D (( /. ) s_temp n_temp) s_temp r_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( /. ) s_temp n_temp) in
                                    write_to_file_dif oc month_temp s_temp d_temp percent_temp dif_temp n_temp r_temp 0. 0.;
		close_out oc;
    let oc = open_out f_ann_30_Ivan in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_30) in
                let r_temp = (calc_r r_Ivan) in
                    let s_temp = (calc_S s_Ivan s_0_Ivan) in
                        let a_temp = (calc_A s_temp r_temp n_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) a_temp percent_temp) in
                                    write_to_file_ann oc month_temp s_temp a_temp percent_temp dif_temp n_temp r_temp 0. 0.;
    close_out oc;
    let oc = open_out f_dif_30_Ivan in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n_30) in
                let r_temp = (calc_r r_Ivan) in
                    let s_temp = (calc_S s_Ivan s_0_Ivan) in
                        let d_temp = (calc_D (( /. ) s_temp n_temp) s_temp r_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( /. ) s_temp n_temp) in
                                    write_to_file_dif oc month_temp s_temp d_temp percent_temp dif_temp n_temp r_temp 0. 0.;
		close_out oc;
