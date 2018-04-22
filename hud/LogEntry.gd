extends CenterContainer

func set_text(txt):
    get_node("Label").text = txt

func set_strikethrough(strike):
    if strike:
        get_node("Strike").show()
    else:
        get_node("Strike").hide()