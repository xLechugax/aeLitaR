package crud.gestorFiles;

import java.sql.*;
import bd.*;
import crud.getData.ImagenVO;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class gestorDataFile {

    /*Metodo listar*/
    public ArrayList<ImagenVO> Listar_DataFile() {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * FROM archivo";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String[] parts = null;
                String nombre = "";
                ImagenVO vo = new ImagenVO();
                vo.setIdArchivo(rs.getString(1));
                vo.setIdEmpresa(rs.getInt(2));
                vo.setidAvance(rs.getInt(3));
                vo.setidTarea(rs.getInt(4));
                vo.setidTrabajo(rs.getInt(5));
                vo.setidProcedimiento(rs.getInt(6));
                vo.setidPaso(rs.getInt(7));

                nombre = rs.getString(9);
                parts = nombre.split("\\.");

                vo.setNombreFile(parts[0]);
                vo.setTypeFile(parts[1].toLowerCase());
                vo.setDetalle("" + rs.getString(11));
                list.add(vo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                rs.close();

            } catch (Exception ex) {
            }
        }
        return list;
    }
    
    public ArrayList<ImagenVO> Listar_DataFile_idOT(int idOT, int idEmpresa) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * FROM archivo where archivo.idOrdenTrabajo="+idOT+" and archivo.idEmpresa="+idEmpresa;
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String[] parts = null;
                String nombre = "";
                ImagenVO vo = new ImagenVO();
                vo.setIdArchivo(rs.getString(1));
                vo.setIdEmpresa(rs.getInt(2));
                vo.setidAvance(rs.getInt(3));
                vo.setidTarea(rs.getInt(4));
                vo.setidTrabajo(rs.getInt(5));
                vo.setidProcedimiento(rs.getInt(6));
                vo.setidPaso(rs.getInt(7));

                nombre = rs.getString(9);
                parts = nombre.split("\\.");

                vo.setNombreFile(parts[0]);
                vo.setTypeFile(parts[1].toLowerCase());
                vo.setDetalle("" + rs.getString(11));
                list.add(vo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                rs.close();

            } catch (Exception ex) {
            }
        }
        return list;
    }
    
    public ArrayList<ImagenVO> Listar_DataFile_idTarea(int idTarea, int idEmpresa) {
        ArrayList<ImagenVO> list = new ArrayList<ImagenVO>();
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * FROM archivo where archivo.idTarea="+idTarea+" and archivo.idEmpresa="+idEmpresa;
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String[] parts = null;
                String nombre = "";
                ImagenVO vo = new ImagenVO();
                vo.setIdArchivo(rs.getString(1));
                vo.setIdEmpresa(rs.getInt(2));
                vo.setidAvance(rs.getInt(3));
                vo.setidTarea(rs.getInt(4));
                vo.setidTrabajo(rs.getInt(5));
                vo.setidProcedimiento(rs.getInt(6));
                vo.setidPaso(rs.getInt(7));

                nombre = rs.getString(9);
                parts = nombre.split("\\.");

                vo.setNombreFile(parts[0]);
                vo.setTypeFile(parts[1].toLowerCase());
                vo.setDetalle("" + rs.getString(11));
                list.add(vo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                rs.close();

            } catch (Exception ex) {
            }
        }
        return list;
    }

    /*Metodo agregar*/
    public void agregar_Imagen(ImagenVO dataVO) {
        Connection conn = ConexionBD.getConexion();
        if (dataVO.getidTrabajo() != 0) {
            String sql = "INSERT INTO `archivo` (`idEmpresa`, archivo, `nombre`, `type`, `idOrdenTrabajo`,`idTarea`) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = null;
            try {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, dataVO.getIdEmpresa());
                ps.setBlob(2, dataVO.getArchivo());
                ps.setString(3, dataVO.getNombreFile());
                ps.setString(4, dataVO.getTypeFile());
                ps.setInt(5, dataVO.getidTrabajo());
                ps.setInt(6, dataVO.getidTarea());
                ps.executeUpdate();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } finally {
                try {
                    ps.close();

                } catch (Exception ex) {
                }
            }
        } else {
            String sql = "INSERT INTO `archivo` (`idEmpresa`, archivo, `nombre`, `type`, `idOrdenTrabajo`) VALUES (?,?,?,?,?)";
            PreparedStatement ps = null;
            try {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, dataVO.getIdEmpresa());
                ps.setBlob(2, dataVO.getArchivo());
                ps.setString(3, dataVO.getNombreFile());
                ps.setString(4, dataVO.getTypeFile());
                ps.setInt(5, dataVO.getidTrabajo());
                ps.executeUpdate();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } finally {
                try {
                    ps.close();

                } catch (Exception ex) {
                }
            }
        }
    }

    /*Metodo Modificar Archivo*/
    public void modificar_Imagen(ImagenVO dataVO) {
        Connection conn = ConexionBD.getConexion();
        String sql = "UPDATE archivo SET archivo = ?, nombre = ?, type = ?, detalleArchivo = ? WHERE idArchivo = ?";
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setBlob(1, dataVO.getArchivo());
            ps.setString(2, dataVO.getNombreFile());
            ps.setString(3, dataVO.getTypeFile());
            ps.setString(4, dataVO.getDetalle());
            ps.setString(5, dataVO.getIdArchivo());
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();

            } catch (Exception ex) {
            }
        }
    }

    /*Metodo Eliminar*/
    public void eliminar_Imagen(String id) {
        Connection conn = ConexionBD.getConexion();
        String sql = "DELETE FROM archivo WHERE idArchivo = ?";
        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();

            } catch (Exception ex) {
            }
        }
    }

    public void descargar_Archivo(ImagenVO dataVO) {
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT archivo, type, nombre FROM archivo WHERE idArchivo = ?";
        ResultSet rs = null;
        PreparedStatement ps = null;
        InputStream BAYS = null;
        byte[] byteFile = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, dataVO.getIdArchivo());

            rs = ps.executeQuery();
            while (rs.next()) {
                dataVO.setArchiveByte(rs.getBytes("archivo"));
                dataVO.setContentType(rs.getString("type"));
                dataVO.setNombreFile(rs.getString("nombre"));
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                ps.close();
                rs.close();
                BAYS.close();
            } catch (Exception ex) {
            }
        }
    }

}
