let s = 400000.;;
let s_0 = 0.;;
let r = 24.;;
let n =
    ( /. ) 4. 12.;;

let folder = "calculations/";;
let f_ann =
    String.cat folder "annuitet.csv"
let f_dif =
    String.cat folder "differential.csv"

let calc_S s s_0 =
    ( -.) s s_0

let calc_r r =
    ( /. ) (( /. ) r 100.) 12.

let calc_n n =
    ( *. ) n 12.

let calc_A s r n =
    Float.round (( *. ) s (( /. ) (( *. ) r (( ** ) (( +. ) 1. r) n)) (( -. ) (( ** ) (( +. ) 1. r) n) 1.)))

let rec write_to_file_ann oc month s a percent dif n total_paid overpayment =
    if month > n then
        Printf.fprintf oc "Упл. всего (р.),%.0f,,,\nОбщ. перепл. (р.),%.0f,,," total_paid overpayment
	else
        begin
            Printf.fprintf oc "%.0f,%.0f,%.0f,%.0f,%.0f\n" month s a percent dif;
            let month = (( +. ) month 1.) in
                let r = (calc_r r) in
                    let total_paid = (( +. ) total_paid a) in
                        let s = (calc_S s dif) in
                            let overpayment = (( +. ) overpayment percent) in
                                let percent = (( *. ) s r) in
                                    let dif = (( -. ) a percent) in
                                        write_to_file_ann oc month s a percent dif n total_paid overpayment
        end ;;

let calc_D dif s r =
    let s_d = (( *. ) s r) in
        Float.round (( +. ) dif s_d)

let rec write_to_file_dif oc month s d percent dif n total_paid overpayment =
    if month > n then
        Printf.fprintf oc "Упл. всего (р.),%.0f,,,\nОбщ. перепл. (р.),%.0f,,," total_paid overpayment
	else
        begin
            Printf.fprintf oc "%.0f,%.0f,%.0f,%.0f,%.0f\n" month s d percent dif;
            let month = (( +. ) month 1.) in
                let r = (calc_r r) in
                    let total_paid = (( +. ) total_paid d) in
                        let s = (calc_S s dif) in
                            let overpayment = (( +. ) overpayment percent) in
                                let percent = (( *. ) s r) in
                                    let d = (( +. ) dif percent) in
                                        write_to_file_dif oc month s d percent dif n total_paid overpayment
        end ;;
let () =
    let oc = open_out f_ann in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n) in
                let r_temp = (calc_r r) in
                    let s_temp = (calc_S s s_0) in
                        let a_temp = (calc_A s_temp r_temp n_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) a_temp percent_temp) in
                                    write_to_file_ann oc month_temp s_temp a_temp percent_temp dif_temp n_temp 0. 0.;
    close_out oc;
    let oc = open_out f_dif in
        Printf.fprintf oc "Мес.,Ост. долга (р.),Общ. сум. выплат (р.),Упл. проц. (р.),Осн. долг (р.)\n";
        let month_temp = 1. in
            let n_temp = (calc_n n) in
                let r_temp = (calc_r r) in
                    let s_temp = (calc_S s s_0) in
                        let d_temp = (calc_D (( /. ) s_temp n_temp) s_temp r_temp) in
                            let percent_temp = (( *. ) s_temp r_temp) in
                                let dif_temp = (( -. ) d_temp percent_temp) in
                                    write_to_file_dif oc month_temp s_temp d_temp percent_temp dif_temp n_temp 0. 0.;
    close_out oc;
