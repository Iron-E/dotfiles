# Increase the temperature by `100`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n 100

# Decrease the temperature by `100`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100

# Increase the brightness by `10%`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d 0.1

# Decrease the brightness by `10%`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.1

# Increase gamma by `0.1`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateGamma d 0.1

# Decrease gamma by `0.1`:
busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateGamma d -0.1
