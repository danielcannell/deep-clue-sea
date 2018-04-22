extends CenterContainer

func set_text(txt):
    get_node("Label").text = txt

func set_strikethrough(strike):
    get_node("Strike").visible = strike