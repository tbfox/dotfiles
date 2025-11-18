def main [] {
    help main
}

def 'main list' [name: string] {
    # main get slackLists.items.list?list_id=(main lists --by-name $name --id)
    open ./tmp.json
    | get items
    | each {
        get fields 
        | each { 
            select key value
        }
    }
}


def 'main lists' [
    --by-name(-n): string 
    --id
] {
    let lists = [
        { id: 'F09R6GGJ2P6' title: 'Bench Tasks' name: 'bench' }
        { id: 'F09LK4233A7' title: 'Improvement Ideas' name: 'improve' }
    ]
    | if ($by_name != null) { 
        where name =~ $by_name
    } else {}
    if $id {
        $lists 
        | get id 
        | if (($lists | length) == 1) { get 0 } else {}
    } else { $lists }
}

def 'main get' [endpoint] {
    (http get $"https://slack.com/api/($endpoint)" -H [
        Authorization $"Bearer ($env.SLACK_TOKEN_USER)"
    ])
    
}

if ($env.SLACK_TOKEN? | is-empty) {
    print $"(ansi red)Error(ansi reset): (ansi purple)SLACK_TOKEN(ansi reset) is requred."
    exit 1
}
# https://pragmint.slack.com/lists/T02DCJN6DAN/F09R6GGJ2P6
