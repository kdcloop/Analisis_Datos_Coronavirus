:::::::::::::::::::::::::::::::::

data3 <- data1 %>% 
  filter(Casos_Totales >= 100) %>% 
  group_by(Location) %>% 
  mutate(dd2 = difftime(Date, min(Date), units = "days") %>% 
           as.numeric(.)) %>% 
  filter(Location %in% c3) %>% 
  ungroup(.) %>% 
  mutate(Location = factor(Location, levels = c3))
  
##########################################################################-
# Creación de gráfico G5 con escala logarítmica y corrección por días de 
# llegada a 100 casos.
  
G5 <- data3 %>% 
  ggplot(aes(x = dd2, y = Casos_Totales, 
             group = Location, colour = Location)) +
  line_t1(1) + line_t1(2) + line_t1(3) + line_t1(7) + line_t1(30) +
  geom_line() + 
  # Seleccionar último punto
  geom_point(data = . %>% group_by(Location) %>% slice(which.max(dd))) + 
  scale_y_log10(breaks = 10^(1:5),
                labels = scales::trans_format("log10", scales::math_format(10^.x)) ) +
  aux_param("D") +
  coord_cartesian(xlim = c(0, 35), ylim = c(1E2, 1E5)) + 
  labs(title = 'Curvas epidémicas de COVID-19 en países seleccionados', 
       subtitle = "Incluye casos relacionados, importados, y en estudio. Escala logarítmica / desde caso 100.", 
       caption = paste0("Estos números no dicen nada sobre el número de personas infectadas, sólo el número de personas quienes han sido positivas. \n",
                        "Este no es un gráfico oficial, sólo informativo. Datos tomados de: ", "https://github.com/CSSEGISandData/COVID-19 \n",
                        a)) +
  geom_dl(aes(label = Location),
          method = list(dl.trans(x = x + 0.1), "last.points", cex = 0.8)) +
  xlab('Días desde el caso 100') +
  annotation_logticks(sides = 'l') +
  theme(panel.grid = element_line(colour = NA), 
        legend.position = "none",
        plot.caption = element_text(hjust = 0))

##########################################################################-
# Adicionar leyendas en guías de duplicación de datos

legend_dup1 <- tribble(
  ~ x, ~ y, ~ label, ~ rot,
  7.3, 1.0 * 10 ^ 4, "Duplica diario",   62, 
  12., 1.0 * 10 ^ 4, "Duplica cada 2d",  50,
  30., 5.0 * 10 ^ 4, "Duplica cada 3d",  00,
  30., 1.0 * 10 ^ 3, "Duplica cada 7d",  00,
  30., 1.8 * 10 ^ 2, "Duplica cada mes", 00)

# Creación de objeto G3 con leyendas en las guías de duplicación
G6 <- G5 + 
  geom_text(data = legend_dup1,
            mapping = aes(x = x, y = y, label = label, angle = rot), 
            stat = "identity", position = "identity", 
            col = "black", inherit.aes = FALSE)


# Almacenamiento de objeto G4 en formato de *pdf* y *png*
ggsave(file.path('Figuras', paste0(today(), "R4", ".pdf")), G6, width = 8, 
       height = 6, device = 'pdf')

ggsave(file.path('Figuras', paste0(today(), "R4", ".png")), 
       G6, width = 8, height = 6, device = 'png', dpi = 300)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        DIRC      t^~~a	Ĳ ^~~a	Ĳ           ��           �~��M��Q43�:Fَ�� ".Rproj.user/A4CF7B29/build_options        ^n����^�,Z�b�          ��           7����ڳ�?����L��� '.Rproj.user/A4CF7B29/console06/INDEX001   ^�,Y3���^�,Y3��(          ��           �X�M2N�2�mv�2G����Ih (.Rproj.user/A4CF7B29/pcs/files-pane.pper  ^�,Y3��(^��z-�(�          ��           <f���S�U�i;��E؀� ).Rproj.user/A4CF7B29/pcs/source-pane.pper ^�,Y3��(^�,Y3��(          ��           ˇ�������ƒ��}� +.Rproj.user/A4CF7B29/pcs/source-window.pper       ^�,Y3��^��z-�k�          ��          4�nG�e\>�b8�� ���\ /.Rproj.user/A4CF7B29/pcs/windowlayoutstate.pper   ^�,Y3��^��z-��          ��           FT��丕,)Q:��%����D" ,.Rproj.user/A4CF7B29/pcs/workbench-pane.pper      ^n��s��^n����          ��          �i&�fb�xq�ʂ�����},� %.Rproj.user/A4CF7B29/persistent-state     ^n��s��^�,Z*`          ��           ?/��̏%������@B�脹  .Rproj.user/A4CF7B29/rmd-outputs  ^n�����^�,Z-��          ��           +�*ƒ��*e�����\� ).Rproj.user/A4CF7B29/saved_source_markers ^��z-��h^��z-��h          ��          ���u�/�.��Zվ�N��T� +.Rproj.user/A4CF7B29/sources/per/t/9982C5A4       ^��z0?΀^��z0?΀          ��          KH��9�t�i�bS�U>�Dq
v� 4.Rproj.user/A4CF7B29/sources/per/t/9982C5A4-contents      ^��z0O�^��z0O�          ��          +��hn�ƎW�m���ts
�C +.Rproj.user/A4CF7B29/sources/per/t/F2985418       ^��z1.|^��z1q           ��          ����X��O�r$,���դ 4.Rproj.user/A4CF7B29/sources/per/t/F2985418-contents      ^r�0&;K�^��z1$�`          ��           ~�9?�����