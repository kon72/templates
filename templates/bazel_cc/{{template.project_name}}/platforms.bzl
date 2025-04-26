"""Build rule to generate 'config_setting' and 'platform' with the same constraints."""

def config_setting_and_platform(
        name,
        constraint_values = [],
        visibility = None):
    """Defines a 'config_setting' and 'platform' with the same constraints.

    Args:
        name: the name for the 'config_setting'. The platform will be suffixed with '_platform'.
        constraint_values: the constraints to meet.
        visibility: the target visibility.
    """
    native.config_setting(
        name = name,
        constraint_values = constraint_values,
        visibility = visibility,
    )

    native.platform(
        name = name + "_platform",
        constraint_values = constraint_values,
        visibility = visibility,
    )
