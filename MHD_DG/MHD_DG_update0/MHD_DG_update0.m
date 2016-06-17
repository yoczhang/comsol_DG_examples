%function out = model
%
% MHD_update0.m
%
% Model exported on Jun 3 2016, 20:15 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/yczhang/Documents/comsol_DG_examples/MHD_DG');

model.label('MHD_DG_update0.mph');

model.comments(['NS\n\nUsing P2+P1, and Picard''s iteration']);

model.baseSystem('none');

model.param.set('nu', '1', 'dynamical viscosity');
model.param.set('sigma', '10');
model.param.set('eipsilon', '1');
model.param.set('beta', '1');
model.param.set('k_m', '1');
model.param.set('nu_m', '1');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').run;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('f1', '2*(2*y-1)*(-3*nu*x^4+6*nu*x^3-6*nu*x^2*y^2+6*nu*x^2*y-3*nu*x^2+6*nu*x*y^2-6*nu*x*y-nu*y^2+nu*y+1)');
model.variable('var1').set('f2', '2*(2*x-1)*(6*nu*x^2*y^2-6*nu*x^2*y+nu*x^2-6*nu*x*y^2+6*nu*x*y-nu*x+3*nu*y^4-6*nu*y^3+3*nu*y^2+1)');
model.variable('var1').set('g1_D', '0', '(u''s)Dirichlet B.C.');
model.variable('var1').set('g2_D', '0', '(v''s)Dirichlet B.C.');
model.variable('var1').set('p_N', '0', '(p''s)Neumann B.C.');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('uexac', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)', 'stokes exact solution');
model.variable('var2').set('vexac', '-x*(x-1)*(2*x-1)*y^2*(y-1)^2', 'stokes exact solution');
model.variable('var2').set('pexac', '(2*x-1)*(2*y-1)', 'stokes exact solution');
model.variable('var2').set('ujump', 'up(u)-down(u)');
model.variable('var2').set('vjump', 'up(v)-down(v)');
model.variable('var2').set('pjump', 'up(p)-down(p)');
model.variable('var2').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var2').set('testvjump', 'test(up(v))-test(down(v))');
model.variable('var2').set('testpjump', 'test(up(p))-test(down(p))');
model.variable('var2').set('unavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)', 'Expression:1/2*{{(ux,uy) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in boundry edges.');
model.variable('var2').set('vnavg', '0.5*((up(vx)+down(vx))*unx+(up(vy)+down(vy))*uny)');
model.variable('var2').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var2').set('testvnavg', '0.5*((test(up(vx))+test(down(vx)))*unx+(test(up(vy))+test(down(vy)))*uny)');
model.variable('var2').set('pavg', '0.5*(up(p)+down(p))');
model.variable('var2').set('testpavg', '0.5*(test(up(p))+test(down(p)))');
model.variable('var2').set('un', 'ux*nx+uy*ny', 'un is used in boundary edges.');
model.variable('var2').set('vn', 'vx*nx+vy*ny');
model.variable('var2').set('testun', 'test(ux)*nx+test(uy)*ny', 'testun is used in boundary edges.');
model.variable('var2').set('testvn', 'test(vx)*nx+test(vy)*ny');
model.variable('var2').set('uerr', 'u-uexac');
model.variable('var2').set('verr', 'v-vexac');
model.variable('var2').set('perr', 'p-pexac');
model.variable('var2').set('u_l2err', 'sqrt(a_int(uerr^2))');
model.variable('var2').set('v_l2err', 'sqrt(a_int(verr^2))');
model.variable('var2').set('p_l2err', 'sqrt(a_int(perr^2))');
model.variable('var2').set('uv_l2err', 'sqrt(u_l2err^2+v_l2err^2)');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('u1jump', 'up(u1)-down(u1)');
model.variable('var3').set('v1jump', 'up(v1)-down(v1)');
model.variable('var3').set('p1jump', 'up(p1)-down(p1)');
model.variable('var3').set('testu1jump', 'test(up(u1))-test(down(u1))');
model.variable('var3').set('testv1jump', 'test(up(v1))-test(down(v1))');
model.variable('var3').set('testp1jump', 'test(up(p1))-test(down(p1))');
model.variable('var3').set('u1navg', '0.5*((up(u1x)+down(u1x))*unx+(up(u1y)+down(u1y))*uny)', 'Expression:1/2*{{(u1x,u1y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou1ndry edges.');
model.variable('var3').set('v1navg', '0.5*((up(v1x)+down(v1x))*unx+(up(v1y)+down(v1y))*uny)');
model.variable('var3').set('testu1navg', '0.5*((test(up(u1x))+test(down(u1x)))*unx+(test(up(u1y))+test(down(u1y)))*uny)');
model.variable('var3').set('testv1navg', '0.5*((test(up(v1x))+test(down(v1x)))*unx+(test(up(v1y))+test(down(v1y)))*uny)');
model.variable('var3').set('p1avg', '0.5*(up(p1)+down(p1))');
model.variable('var3').set('testp1avg', '0.5*(test(up(p1))+test(down(p1)))');
model.variable('var3').set('u1n', 'u1x*nx+u1y*ny', 'u1n is used in bou1ndary edges.');
model.variable('var3').set('v1n', 'v1x*nx+v1y*ny');
model.variable('var3').set('testu1n', 'test(u1x)*nx+test(u1y)*ny', 'testu1n is used in bou1ndary edges.');
model.variable('var3').set('testv1n', 'test(v1x)*nx+test(v1y)*ny');
model.variable('var3').set('u1err', 'u1-ns_uexac');
model.variable('var3').set('v1err', 'v1-ns_vexac');
model.variable('var3').set('p1err', 'p1-ns_pexac');
model.variable('var3').set('u1_l2err', 'sqrt(a_int(u1err^2))');
model.variable('var3').set('v1_l2err', 'sqrt(a_int(v1err^2))');
model.variable('var3').set('p1_l2err', 'sqrt(a_int(p1err^2))');
model.variable('var3').set('u1v1_l2err', 'sqrt(u1_l2err^2+v1_l2err^2)');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').set('u2jump', 'up(u2)-down(u2)');
model.variable('var4').set('v2jump', 'up(v2)-down(v2)');
model.variable('var4').set('p2jump', 'up(p2)-down(p2)');
model.variable('var4').set('testu2jump', 'test(up(u2))-test(down(u2))');
model.variable('var4').set('testv2jump', 'test(up(v2))-test(down(v2))');
model.variable('var4').set('testp2jump', 'test(up(p2))-test(down(p2))');
model.variable('var4').set('u2navg', '0.5*((up(u2x)+down(u2x))*unx+(up(u2y)+down(u2y))*uny)', 'Expression:1/2*{{(u2x,u2y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou2ndry edges.');
model.variable('var4').set('v2navg', '0.5*((up(v2x)+down(v2x))*unx+(up(v2y)+down(v2y))*uny)');
model.variable('var4').set('testu2navg', '0.5*((test(up(u2x))+test(down(u2x)))*unx+(test(up(u2y))+test(down(u2y)))*uny)');
model.variable('var4').set('testv2navg', '0.5*((test(up(v2x))+test(down(v2x)))*unx+(test(up(v2y))+test(down(v2y)))*uny)');
model.variable('var4').set('p2avg', '0.5*(up(p2)+down(p2))');
model.variable('var4').set('testp2avg', '0.5*(test(up(p2))+test(down(p2)))');
model.variable('var4').set('u2n', 'u2x*nx+u2y*ny', 'u2n is used in bou2ndary edges.');
model.variable('var4').set('v2n', 'v2x*nx+v2y*ny');
model.variable('var4').set('testu2n', 'test(u2x)*nx+test(u2y)*ny', 'testu2n is used in bou2ndary edges.');
model.variable('var4').set('testv2n', 'test(v2x)*nx+test(v2y)*ny');

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 3);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').selection.all;

model.physics.create('u_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u_weak_func').identifier('u_weak_func');
model.physics('u_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u_weak_func').feature('ibweak1').selection.all;
model.physics('u_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u_weak_func').feature('weak1').selection.all;
model.physics.create('v_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v_weak_func').identifier('v_weak_func');
model.physics('v_weak_func').field('dimensionless').field('v');
model.physics('v_weak_func').field('dimensionless').component({'v'});
model.physics('v_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v_weak_func').feature('ibweak1').selection.all;
model.physics('v_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v_weak_func').feature('weak1').selection.all;
model.physics.create('p_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p_weak_func').identifier('p_weak_func');
model.physics('p_weak_func').field('dimensionless').field('p');
model.physics('p_weak_func').field('dimensionless').component({'p'});
model.physics('p_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p_weak_func').feature('ibweak1').selection.all;
model.physics('p_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p_weak_func').feature('weak1').selection.all;
model.physics.create('u1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u1_weak_func').identifier('u1_weak_func');
model.physics('u1_weak_func').field('dimensionless').field('u1');
model.physics('u1_weak_func').field('dimensionless').component({'u1'});
model.physics('u1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak1').selection.all;
model.physics('u1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak1').selection.all;
model.physics('u1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak2').selection.all;
model.physics('u1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak2').selection.all;
model.physics.create('v1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v1_weak_func').identifier('v1_weak_func');
model.physics('v1_weak_func').field('dimensionless').field('v1');
model.physics('v1_weak_func').field('dimensionless').component({'v1'});
model.physics('v1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak1').selection.all;
model.physics('v1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak1').selection.all;
model.physics('v1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak2').selection.all;
model.physics('v1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak2').selection.all;
model.physics.create('p1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p1_weak_func').identifier('p1_weak_func');
model.physics('p1_weak_func').field('dimensionless').field('p1');
model.physics('p1_weak_func').field('dimensionless').component({'p1'});
model.physics('p1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p1_weak_func').feature('ibweak1').selection.all;
model.physics('p1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak1').selection.all;
model.physics.create('u2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u2_weak_func').identifier('u2_weak_func');
model.physics('u2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak1').selection.all;
model.physics('u2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak2').selection.all;
model.physics('u2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak1').selection.all;
model.physics('u2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak2').selection.all;
model.physics.create('v2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v2_weak_func').identifier('v2_weak_func');
model.physics('v2_weak_func').field('dimensionless').field('v2');
model.physics('v2_weak_func').field('dimensionless').component({'v2'});
model.physics('v2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak1').selection.all;
model.physics('v2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak2').selection.all;
model.physics('v2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak1').selection.all;
model.physics('v2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak2').selection.all;
model.physics.create('p2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p2_weak_func').identifier('p2_weak_func');
model.physics('p2_weak_func').field('dimensionless').field('p2');
model.physics('p2_weak_func').field('dimensionless').component({'p2'});
model.physics('p2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p2_weak_func').feature('ibweak1').selection.all;
model.physics('p2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p2_weak_func').feature('weak1').selection.all;

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.all;

model.result.table.create('evl2', 'Table');

model.variable('var1').label('all_funs_setting');
model.variable('var2').label('MHD_init0_setting');
model.variable('var3').label('MHD_step1_setting');
model.variable('var4').label('MHD_step2_setting');

model.view('view1').axis.set('abstractviewxscale', '0.0020295202266424894');
model.view('view1').axis.set('ymin', '-0.10462085902690887');
model.view('view1').axis.set('xmax', '1.024999976158142');
model.view('view1').axis.set('abstractviewyscale', '0.0020295202266424894');
model.view('view1').axis.set('abstractviewbratio', '-0.04999998211860657');
model.view('view1').axis.set('abstractviewtratio', '0.04999995231628418');
model.view('view1').axis.set('abstractviewrratio', '0.39298880100250244');
model.view('view1').axis.set('xmin', '-0.024999964982271194');
model.view('view1').axis.set('abstractviewlratio', '-0.3929888904094696');
model.view('view1').axis.set('ymax', '1.1046208143234253');
model.view('view2').axis.set('ymin', '-1.3080406188964844');
model.view('view2').axis.set('xmax', '2.2925000190734863');
model.view('view2').axis.set('xmin', '-1.5924999713897705');
model.view('view2').axis.set('ymax', '1.708040714263916');

model.cpl('intop1').label('area_int');
model.cpl('intop1').set('opname', 'a_int');

model.physics('u_weak_func').label('stokes_init0_u');
model.physics('u_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u_weak_func').feature('wfeq1').set('weak', 'nu*(ux*test(ux)+uy*test(uy))-p*test(ux)-f1*test(u)');
model.physics('u_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*unx');
model.physics('u_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1_D-nu*sigma/h^beta*test(u)*g1_D');
model.physics('v_weak_func').label('stokes_init0_v');
model.physics('v_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v_weak_func').feature('wfeq1').set('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f2*test(v)');
model.physics('v_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*uny');
model.physics('v_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g2_D-nu*sigma/h^beta*test(v)*g2_D');
model.physics('p_weak_func').label('stokes_init0_p');
model.physics('p_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p_weak_func').feature('wfeq1').set('weak', '-test(p)*(ux+vy)+test(p)*p*1e-6');
model.physics('p_weak_func').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*unx+vjump*uny)');
model.physics('p_weak_func').feature('weak1').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(g1_D*nx+g2_D*ny)');
model.physics('u1_weak_func').label('ns_step1_u1');
model.physics('u1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u1_weak_func').feature('wfeq1').set('weak', 'nu*(u1x*test(u1x)+u1y*test(u1y))+(u*u1x+v*u1y)*test(u1)+0.5*(ux+vy)*u1*test(u1)-p1*test(u1x)-f1*test(u1)');
model.physics('u1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u1jump*testu1jump-nu*u1navg*testu1jump+nu*eipsilon*testu1navg*u1jump+p1avg*testu1jump*unx');
model.physics('u1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*g1_D-nu*sigma/h^beta*test(u1)*g1_D');
model.physics('u1_weak_func').feature('ibweak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(u1))*(down(u1)-up(u1))+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(u1))*(up(u1)-down(u1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(u1*test(u1))+down(u1*test(u1))))');
model.physics('u1_weak_func').feature('weak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(u1))*(down(u1)-g1_D)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(u1))*(up(u1)-g1_D)-0.5*(u*nx+v*ny)*(u1*test(u1))');
model.physics('v1_weak_func').label('ns_step1_v1');
model.physics('v1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v1_weak_func').feature('wfeq1').set('weak', 'nu*(v1x*test(v1x)+v1y*test(v1y))+(u*v1x+v*v1y)*test(v1)+0.5*(ux+vy)*v1*test(v1)-p1*test(v1y)-f2*test(v1)');
model.physics('v1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v1jump*testv1jump-nu*v1navg*testv1jump+nu*eipsilon*testv1navg*v1jump+p1avg*testv1jump*uny');
model.physics('v1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*g2_D-nu*sigma/h^beta*test(v1)*g2_D');
model.physics('v1_weak_func').feature('ibweak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(v1))*(down(v1)-up(v1))+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(v1))*(up(v1)-down(v1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(v1*test(v1))+down(v1*test(v1))))');
model.physics('v1_weak_func').feature('weak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(v1))*(down(v1)-g2_D)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(v1))*(up(v1)-g2_D)-0.5*(u*nx+v*ny)*(v1*test(v1))');
model.physics('p1_weak_func').label('ns_step1_p1');
model.physics('p1_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p1_weak_func').feature('wfeq1').set('weak', '-test(p1)*(u1x+v1y)+test(p1)*p1*1e-6');
model.physics('p1_weak_func').feature('ibweak1').set('weakExpression', 'testp1avg*(u1jump*unx+v1jump*uny)');
model.physics('p1_weak_func').feature('weak1').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(g1_D*nx+g2_D*ny)');
model.physics('u2_weak_func').label('ns_step2_u2');
model.physics('u2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u2_weak_func').feature('wfeq1').set('weak', 'nu*(u2x*test(u2x)+u2y*test(u2y))+(u1*u2x+v1*u2y)*test(u2)+0.5*(u1x+v1y)*u2*test(u2)-p2*test(u2x)-f1*test(u2)');
model.physics('u2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u2jump*testu2jump-nu*u2navg*testu2jump+nu*eipsilon*testu2navg*u2jump+p2avg*testu2jump*unx');
model.physics('u2_weak_func').feature('ibweak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(u2))*(down(u2)-up(u2))+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(u2))*(up(u2)-down(u2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(u2*test(u2))+down(u2*test(u2))))');
model.physics('u2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u2*test(u2)-nu*u2n*test(u2)+nu*eipsilon*testu2n*u2+p2*test(u2)*nx-nu*eipsilon*testu2n*g1_D-nu*sigma/h^beta*test(u2)*g1_D');
model.physics('u2_weak_func').feature('weak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(u2))*(down(u2)-g1_D)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(u2))*(up(u2)-g1_D)-0.5*(u1*nx+v1*ny)*(u2*test(u2))');
model.physics('v2_weak_func').label('ns_step2_v2');
model.physics('v2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v2_weak_func').feature('wfeq1').set('weak', 'nu*(v2x*test(v2x)+v2y*test(v2y))+(u1*v2x+v1*v2y)*test(v2)+0.5*(u1x+v1y)*v2*test(v2)-p2*test(v2y)-f2*test(v2)');
model.physics('v2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v2jump*testv2jump-nu*v2navg*testv2jump+nu*eipsilon*testv2navg*v2jump+p2avg*testv2jump*uny');
model.physics('v2_weak_func').feature('ibweak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(v2))*(down(v2)-up(v2))+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(v2))*(up(v2)-down(v2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(v2*test(v2))+down(v2*test(v2))))');
model.physics('v2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v2*test(v2)-nu*v2n*test(v2)+nu*eipsilon*testv2n*v2+p2*test(v2)*ny-nu*eipsilon*testv2n*g2_D-nu*sigma/h^beta*test(v2)*g2_D');
model.physics('v2_weak_func').feature('weak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(v2))*(down(v2)-g2_D)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(v2))*(up(v2)-g2_D)-0.5*(u1*nx+v1*ny)*(v2*test(v2))');
model.physics('p2_weak_func').label('ns_step2_p2');
model.physics('p2_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p2_weak_func').feature('wfeq1').set('weak', '-test(p2)*(u2x+v2y)+test(p2)*p2*1e-6');
model.physics('p2_weak_func').feature('ibweak1').set('weakExpression', 'testp2avg*(u2jump*unx+v2jump*uny)');
model.physics('p2_weak_func').feature('weak1').set('weakExpression', 'test(p2)*(u2*nx+v2*ny)-test(p2)*(g1_D*nx+g2_D*ny)');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1/16');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').run;

model.frame('material1').sorder(1);

model.result.table('evl2').label('Evaluation 2D');
model.result.table('evl2').comments([native2unicode(hex2dec({'4e' 'a4'}), 'unicode')  native2unicode(hex2dec({'4e' '92'}), 'unicode')  native2unicode(hex2dec({'76' '84'}), 'unicode')  native2unicode(hex2dec({'4e' '8c'}), 'unicode')  native2unicode(hex2dec({'7e' 'f4'}), 'unicode')  native2unicode(hex2dec({'50' '3c'}), 'unicode') ]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'u_weak_func' 'on' 'v_weak_func' 'on' 'p_weak_func' 'on' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'on' 'v1_weak_func' 'on'  ...
'p1_weak_func' 'on' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'on' 'v2_weak_func' 'on' 'p2_weak_func' 'on'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').attach('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature.remove('fcDef');

model.study('std1').label('solve_stokes_init0_uvp');
model.study('std2').label('solve_ns_step1_u1v1p1');
model.study('std3').label('solve_ns_step2_u2v2p2');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

%out = model;